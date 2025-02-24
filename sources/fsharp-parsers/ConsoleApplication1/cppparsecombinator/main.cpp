﻿
#include <string>
#include <iterator>
#include <functional>
#include <cassert>
#include <memory>
#include <map>
#include <vector>
//#include <experimental\any>

template <typename T>
struct function_traits
	: public function_traits<decltype(&T::operator())>
{};

template <typename ClassType, typename ReturnType, typename... Args>
struct function_traits<ReturnType(ClassType::*)(Args...) const>
{
	enum { arity = sizeof...(Args) };
	typedef ReturnType result_type;
	template <size_t i>
	struct arg
	{
		typedef typename std::tuple_element<i, std::tuple<Args...>>::type type;
	};
};

template<typename Derived, typename Base, typename Del>
std::unique_ptr<Derived, Del> down_cast(std::unique_ptr<Base, Del>&& p)
{
	auto d = static_cast<Derived *>(p.release());
	return std::unique_ptr<Derived, Del>(d, std::move(p.get_deleter()));
}

//FROM http://alexandria.tue.nl/extra1/wskrap/publichtml/200402.pdf
//1. Operational semantics.A computer program is modeled as an execution of an abstract machine.
//A state of such a machine is a valuation of variables, a transition between states is an 
//elementary program instruction.Pioneer of this ﬁeld is McCarthy[64]. 

class OperationalSemantics
{
public:
	//A state of such a machine is a valuation of variables
	std::map<std::string, void*> GetState() const
	{
		auto map = std::map<std::string, void*>();
		for (auto &v : Variables)
		{
			map[v] = Eval(v);
		}
		return map;
	}
private:
	std::function<void*(std::string)> Eval;
	std::vector<std::string> Variables;
};

//2. Denotational semantics.More abstract than operational semantics, computer programs are
//usually modeled by a function transforming input into output.Most well - known 
//are Scott and Strachey[92].

class DenotationalSemantics
{
public:
	void Run(std::map<std::string, void*> input, std::map<std::string, void*>output)
	{

	}
};

namespace denotational
{
	char pchar(char expected)
	{

	}
}

//3. Axiomatic semantics.Here, emphasis is put on proof methods proving programs 
//correct.Central notions are program assertions, proof triples consisting of precondition, 
//program statement and postcondition, and invariants.Pioneers are Floyd[38] and Hoare[53].


template <typename TValue>
struct ParserResult
{
	bool Success;
	TValue Value;

	ParserResult(TValue value) : Value(value), Success(true)
	{
	}

	ParserResult() : Success(false)
	{
	}
};

template <typename TValue>
struct SuccessParserResult : ParserResult<TValue>
{
	SuccessParserResult(TValue value) : ParserResult(value)
	{
	}
};

template <typename TValue>
struct FailureParserResult : ParserResult<TValue>
{
	FailureParserResult()
	{
	}
};

template <typename TValue>
ParserResult<TValue> success(TValue value)
{
	return SuccessParserResult<TValue>(value);
}

template <typename TValue>
ParserResult<TValue> failure()
{
	return FailureParserResult<TValue>();
}

template<typename TObject, typename TValue>
class Parser
{
public:
	typedef typename TObject::iterator TIterator;

	Parser(std::function<ParserResult<TValue>(TIterator&)> pf) : ParserFunction(pf)
	{
	}

	ParserResult<TValue> Parse(TIterator& iterator) const
	{
		auto r = ParserFunction(iterator);
		++iterator;
		return r;
	}
private:
	std::function<ParserResult<TValue>(TIterator&)> ParserFunction;
};


namespace builders
{
	template<typename T>
	struct parsers
	{
		static Parser<typename T, char> pchar(char c)
		{
			return Parser<typename T, char>([c](T::iterator& iterator) {
				auto currentchar = *iterator;
				if (currentchar == c) return success(currentchar);
				else return failure<char>();
			});
		}

		template<typename F,
			typename FReturnType = typename function_traits<F>::result_type,
			typename FArg0 = typename function_traits<F>::arg<0>::type,
			typename FArg1 = typename function_traits<F>::arg<1>::type>
		static Parser<typename T, FReturnType> andThen(Parser<typename T, FArg0> l, Parser<typename T, FArg1> r, F f)
		{
			return Parser<typename T, FReturnType>([l, r, f](typename T::iterator obj) {
				auto resultl = l.Parse(obj);
				if (resultl.Success) {
					auto resultr = r.Parse(obj);
					if (resultr.Success) {
						return success(f(resultl.Value, resultr.Value));
					}
				}
				return failure<FReturnType>();
			});
		}

		template<typename TValueL, typename TValueR>
		static Parser<typename T, std::tuple<TValueL, TValueR>> andThen(Parser<typename T, TValueL> l, Parser<typename T, TValueR> r)
		{
			return andThen(l, r, [](TValueL vl, TValueR vr) {return std::make_tuple(vl, vr); });
		}

		template<typename F,
			typename TValue = typename function_traits<F>::result_type,
			typename TValueL = typename function_traits<F>::arg<0>::type>
			static Parser<typename T, TValue> map(Parser<typename T, TValueL> l, F f)
		{
			return _map<TValue, TValueL>(l, f);
		}

		template<typename F,
			typename TValue = typename function_traits<F>::result_type,
			typename TValueL = typename function_traits<F>::arg<0>::type,
			typename TValueR = typename function_traits<F>::arg<1>::type>
			static Parser<typename T, TValue> map(Parser<typename T, std::tuple<TValueL, TValueR>> l, F f)
		{
			return _map<TValue, TValueL, TValueR>(l, f);
		}

		template<typename TValue>
		static Parser<typename T, TValue> ret(TValue value)
		{
			return Parser<typename T, TValue>([value](typename T obj) {
				return success(value);
			});
		}

		//lift1 : (FArg0 -> FReturnType) -> (Parser FARg0 -> Parser FReturnType)
		template<typename F,
			typename FReturnType = typename function_traits<F>::result_type,
			typename FArg0 = typename function_traits<F>::arg<0>::type>
			static std::function<Parser<typename T, FReturnType>(Parser<typename T, FArg0>)> lift1(F f)
		{
			return [f](Parser<typename T, FArg0> l) {
				return map(l, f);
			};
		}

		//lift2: (FArg0 -> FArg1 -> FReturnType) -> (Parser FArg0 -> Parser FArg1 -> Parser FReturnType)
		template<typename F,
			typename FReturnType = typename function_traits<F>::result_type,
			typename FArg0 = typename function_traits<F>::arg<0>::type,
			typename FArg1 = typename function_traits<F>::arg<1>::type>
			static std::function<Parser<typename T, FReturnType>(Parser<typename T, FArg0>, Parser<typename T, FArg1>)> lift2(F f)
		{
			return [f](Parser<typename T, FArg0> l, Parser<typename T, FArg1> r) {
				return andThen(l, r, f);
			};
		}

	private:
		template<typename TValue, typename TValueL>
		static Parser<typename T, TValue> _map(Parser<typename T, TValueL> l, std::function<TValue(TValueL)> f)
		{
			return  Parser<typename T, TValue>([l, f](typename T::iterator obj) {
				auto r = l.Parse(obj);
				if (r.Success) {
					auto value = f(r.Value);
					return success(value);
				}
				return failure<TValue>();
			});
		}

		template<typename TValue, typename TValueL, typename TValueR>
		static Parser<typename T, TValue> _map(Parser<typename T, std::tuple<TValueL, TValueR>> l, std::function<TValue(TValueL, TValueR)> f)
		{
			return Parser<typename T, TValue>([l, f](typename T::iterator obj) {
				auto r = l.Parse(obj);
				if (r.Success) {
					auto valuel = std::get<0>(r.Value);
					auto valuer = std::get<1>(r.Value);
					auto value = f(valuel, valuer);
					return success(value);
				}
				return failure<TValue>();
			});
		}
	};
}

template<typename T, typename TValueL, typename TValueR>
Parser<typename T, std::tuple<TValueL, TValueR>> operator & (Parser<typename T, TValueL> l, Parser<typename T, TValueR> r)
{
	return builders::parsers<T>::andThen(l, r);
}

template<typename T, typename F,
	typename TValue = typename function_traits<F>::result_type,
	typename TValueL = typename function_traits<F>::arg<0>::type>
	Parser<typename T, TValue> operator >> (Parser<typename T, TValueL> l, F f)
{
	return builders::parsers<T>::map(l, f);
} 

void main()
{
	auto text = std::string("11");
	auto i = text.begin();

	auto stringparser = builders::parsers<std::string>();
	auto atoi = [](char c) {
		return (c - '0') % 48;
	};
	auto sum = [](int l, int r) {return l + r; };

	//PARSER COMPOSITION WITH OPERATORS
	auto p1 = stringparser.pchar('1');
	auto p11 = ((p1 >> atoi) & (p1 >> atoi)) >> sum;

	auto result = p11.Parse(i);
	assert(result.Value == 2);

	//PARSER COMPOSITION WITH LIFTEDFUNCTIONS
	auto pAtoi = stringparser.lift1(atoi);
	auto pSum = stringparser.lift2(sum);
	p11 = pSum(pAtoi(p1), pAtoi(p1));

	i = text.begin();
	result = p11.Parse(i);
	assert(result.Value == 2);
}