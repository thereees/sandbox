// var.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

template <typename T, typename TR> using F = TR(*)(const T&);

template <typename T>
class var
{
	T Value;
public:
	var(const T& v) : Value(v)
	{
	}
	template <typename TR> var<TR> map(F<T,TR> f)
	{
		return { f(Value) };
	}
};
using vint = var<int>;

template <typename F, typename A>
class partial_application
{
	F f;
	A a;
public:
	partial_application(F &f, A& a) : F(f), A(a)
	{
	}
	template <typename TR, typename B>
	TR operator ()(const B& b) const
	{
		return F(a, b);
	}
};

F<>
template <typename A, typename TR>
using lpa = partial_application<var<TR>(*)(const F<A, TR>&, const var<A>&), const F<A, TR>&)>;
template<typename A, typename TR> var<TR> lifted(const F<A,TR>& f, const var<A>& v)
{
	return v.map(f);
}

template <typename A, typename TR>
lpa<A,TR> lift(const F<A,TR>& f)
{
	return partial_application{ lifted, f};
}

int inc(const int& i)
{
	return i + 1;
}

int main()
{
	auto linc = lift(&inc);

	vint i = 10;
	i = linc(i);

	return 0;
}

