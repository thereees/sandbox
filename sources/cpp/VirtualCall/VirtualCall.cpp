// VirtualCall.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <map>
#include <functional>

#define EVAL0(...) __VA_ARGS__
#define EVAL1(...) EVAL0(EVAL0(EVAL0(__VA_ARGS__)))
#define EVAL2(...) EVAL1(EVAL1(EVAL1(__VA_ARGS__)))
#define EVAL3(...) EVAL2(EVAL2(EVAL2(__VA_ARGS__)))
#define EVAL4(...) EVAL3(EVAL3(EVAL3(__VA_ARGS__)))
#define EVAL(...)  EVAL4(EVAL4(EVAL4(__VA_ARGS__)))
#define MAP_END(...)
#define MAP_OUT
#define MAP_COMMA ,
#define MAP_GET_END2() 0, MAP_END
#define MAP_GET_END1(...) MAP_GET_END2
#define MAP_GET_END(...) MAP_GET_END1
#define MAP_NEXT0(test, next, ...) next MAP_OUT
#define MAP_NEXT1(test, next) MAP_NEXT0(test, next, 0)
#define MAP_NEXT(test, next)  MAP_NEXT1(MAP_GET_END test, next)
#define MAP0(f, x, peek, ...) f(x) MAP_NEXT(peek, MAP1)(f, peek, __VA_ARGS__)
#define MAP1(f, x, peek, ...) f(x) MAP_NEXT(peek, MAP0)(f, peek, __VA_ARGS__)
#define MAP_LIST_NEXT1(test, next) MAP_NEXT0(test, MAP_COMMA next, 0)
#define MAP_LIST_NEXT(test, next)  MAP_LIST_NEXT1(MAP_GET_END test, next)
#define MAP_LIST0(f, x, peek, ...) f(x) MAP_LIST_NEXT(peek, MAP_LIST1)(f, peek, __VA_ARGS__)
#define MAP_LIST1(f, x, peek, ...) f(x) MAP_LIST_NEXT(peek, MAP_LIST0)(f, peek, __VA_ARGS__)
#define MAP(f, ...) EVAL(MAP1(f, __VA_ARGS__, ()()(), ()()(), ()()(), 0))
#define MAP_LIST(f, ...) EVAL(MAP_LIST1(f, __VA_ARGS__, ()()(), ()()(), ()()(), 0))


class ObjectTypeAtFirstByteTrait
{
protected:
	template <typename T>
	int GetType(const T& object) const noexcept
	{
		char * bytes = (char*)(void*)&object;
		return (int)bytes[0];
	}
};

struct VirtualCallEntry
{
	int Type;
	void * Function;
};

template <
	int N,
	typename TGetType = ObjectTypeAtFirstByteTrait>
	class VirtualCall : public TGetType
{
	VirtualCallEntry Functions[N];
public:
	template<typename T>
	void add(int type, void(*f) (const T&))
	{
		Functions[type] = { type,(void*)f };
	}

	template <typename T>
	void call(const T& item)
	{
		int type = TGetType::GetType(item);
		void* f = Functions[(int)type].Function;

		(static_cast<void(*)(const T&)>(f))(item);
	}
};

#define TYPES(T1, I1, T2, I2)	\
const int TYPE_ ## T1 = I1;		\
const int TYPE_ ## T2 = I2;

#define VC2(Name, F, T1, T2)	\
static VirtualCall<2> VC ## Name ## F;			\
void Init ## Name ## F(){						\
	VC ## Name ## F.add<T1>(TYPE_ ## T1, F);	\
	VC ## Name ## F.add<T2>(TYPE_ ## T2, F);	\
}												\
void F (const Name & item) {					\
	VC ## Name ## F.call(item);					\
}

TYPES(Dog, 0, Cat, 1)

struct Animal
{
	Animal(int type) : Type(type) {}
	int Type;
};

struct Dog : public Animal
{
	Dog() : Animal(TYPE_Dog) {}
};

struct Cat
{
	int Type;
	Cat() : Type(TYPE_Cat)
	{

	}
};

void Cry(const Dog& animal)
{
	std::cout << "Barf!" << std::endl;
}

void Cry(const Cat& animal)
{
	std::cout << "Meow!" << std::endl;
}

VC2(Animal, Cry, Dog, Cat);

int main()
{
	InitAnimalCry();

	Cat cat1;
	Dog dog1;

	VCAnimalCry.call(cat1);
	VCAnimalCry.call(dog1);

	Animal& animal1 = dog1;
	Cry(animal1);
	return 0;
}

