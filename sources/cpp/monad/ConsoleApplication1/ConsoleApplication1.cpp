// ConsoleApplication1.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <string>
#include <functional>
#include <iostream>
#include <tuple>

template <typename T>
class InverseWrapper
{
	bool IsEmpty;
	const T Value;
public:
	InverseWrapper(bool isEmpty, const T& value) : IsEmpty(isEmpty), Value(value)
	{
	}

	template <typename F, typename std::enable_if<std::is_invocable_r<void, F>::value, int>::type = 0>
	void operator >> (F f)
	{
		if (IsEmpty) f();
	}
};

template <typename T>
class MustReturnInverseWrapper
{
	bool IsEmpty;
	const T Value;
public:
	MustReturnInverseWrapper(bool isEmpty, const T& value) : IsEmpty(isEmpty), Value(value)
	{
	}

	template <typename F, typename std::enable_if<std::is_invocable_r<T, F>::value, int>::type = 0>
	T operator >> (F f)
	{
		if (IsEmpty) return f();
		else return Value;
	}
};
template <typename T>
class Wrapper
{
	bool IsEmpty;
	T Value;
public:
	Wrapper() : IsEmpty(true)
	{
	}

	Wrapper(const T&& item) : IsEmpty(false), Value(item)
	{
	}

	template <typename F,
		typename T2 = std::result_of<F(const T&)>::type,
		typename std::enable_if<std::negation<std::is_void<T2>>::value, int>::type = 0,
		typename std::enable_if<std::is_invocable_r<T2, F, const T&>::value, int>::type = 0>
		MustReturnInverseWrapper<T2> operator >> (F f)
	{
		T2 value;
		if (!IsEmpty) value = f(Value);
		return { IsEmpty, value };
	}

	template <typename F,
		typename T2 = std::result_of<F(const T&)>::type,
		typename std::enable_if<std::is_void<T2>::value, int>::type = 0,
		typename std::enable_if<std::is_invocable_r<void, F, const T&>::value, int>::type = 0>
	InverseWrapper<T> operator >> (F f)
	{
		if (!IsEmpty) f(Value);
		return { IsEmpty, Value };
	}

	template <typename T2>
	Wrapper<std::tuple<T, T2>> Join(Wrapper<T2> w2)
	{
		if (IsEmpty || w2.IsEmpty)
			return {};
		return std::make_tuple(Value, w2.Value);
	}
};

template<typename T1, typename T2, template<typename> typename W>
W<std::tuple<T1, T2>> operator + (W<T1> w1, W<T2> w2)
{
	return w1.Join(w2);
}

template <typename T, template<typename> typename W>
class Enumerable
{
	unsigned int Count;
	char ** Strings;
public:
	Enumerable(unsigned int count, char** strings)
	{
		Count = count;
		Strings = strings;
	}

	W<T> operator [] (unsigned int i) const noexcept
	{
		if (i < Count)
			return std::string{ Strings[i] };
		else
			return {};
	}

	W<T> First() const noexcept
	{
		return std::string{ Strings[0] };
	}
};

Enumerable<std::string, Wrapper> wrap(unsigned int count, char** strings)
{
	return { count, strings };
}

#define VARXY auto[x,y] = item; x; y;

#define ONVALUE >> [&](const auto& item) -> void
#define ONEMPTY >> [&](void) -> void

#define MAPVALUE >> [&](const auto& item) -> auto 
#define MAPEMPTY >> [&]() -> auto

int main(int argc, char**argv)
{
	auto args = wrap((unsigned int)argc, argv);
	
	args[0] + args[1]
		ONVALUE{ VARXY; std::cout << x << std::endl; }
	ONEMPTY{ std::cout << "Empty" << std::endl; };

	auto strmap = args[0] + args[1]
		MAPVALUE{ return "Full"; }
	MAPEMPTY{ return "Empty"; };
	std::cout << strmap << std::endl;

	std::string str;
	std::cin >> str;
	return 0;
}

