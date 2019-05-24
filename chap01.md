# 1장 다중 통화를 지원하는 Money 객체



## 1. 목표 정하기

- 통화가 다른 두 금액을 더해 주어진 환율에 맞게 출력하기
- 금액 * 주 에 값을 결과로 얻기

### 1장 목표

​    금액 * 주 값을 결과로 얻기

## 2. 테스트 생성하기

테스트를 먼저 만들어야한다. 쉬운 테스트를 만들어보자. 

대충 코드를 짜본다.

```ruby 
# example

require 'test/unit' 

class DollarTests < Test::Unit::TestCase
  def test_multiplication()
	five = Dollar.new(5)
	five.times(2)
	assert_equal(10, five.amount)
  end
end

```

```console
=> 
Loaded suite chap01
Started
E
===

Error: test_multiplication(DollarTests):

  NameError: uninitialized constant DollarTests::Dollar

  Did you mean?  DollarTests

chap01.rb:5:in `test_multiplication'

===

```

빨간 막대 에러가 나온다. 

## 3. 초록 막대를 확인할수 있는 최소 작업 단위 구성하기

Dollar 클래스 만들기 

```ruby 
class Dollar
  attr_accessor :amount
  def initialize(amount)
    @amount = amount
  end
  def times(multiplier)
  end
end

```

다시 실행

```ruby
Loaded suite chap01
Started
F
====
Failure: test_multiplication(DollarTests)

chap01.rb:8:in `test_multiplication'

    5:     def test_multiplication()

    6:         five = Dollar.new(5)

    7:         five.times(2)

=>  8:         assert_equal(10, five.amount)

    9:     end

   10: end

<10> expected but was

<5>

===

```

컴파일 에러는 해결되었다. 값의 문제가 나왔다. 

## 4. 진행 전 일반화 하기

위에 `amount=10` 은 `test_multiplication` 에서 넘어오는 값을 넣은 것이기 때문에 중복이다. 

중복을 제거하기 위해 이 값을 `times` 메서드에 옮기자.

## 5. 중복 제거

```ruby
class Dollar
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    self.amount = 5 * 2
  end

end

```

```console
Loaded suite chap01

Started

.

Finished in 0.000667 seconds.

---

1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications

100% passed

---

1499.25 tests/s, 1499.25 assertions/s
```

영겁의 느린 단위이지만, 작업 능력을 갖추기 위해 중요하다. 

## 4. 진행 전 일반화하기

`times` 에서 넘어온 `5` 는  `test_multiplation` 에 있는 값이며, 생성자에서 넘어오는 값이다. 

생성자를 만들어보자

## 5. 중복 제거

```ruby
class Dollar
  attr_accessor :amount

  def initialize(amount)
	@amount = amount
  end

  def times(multiplier)
	self.amount = self.amount  * 2
  end
end

```

## 4. 진행 전 일반화하기

`times` 에 존재하는 `2` 는 `test` 메서드의 매개변수 값이다. 변경해주자.

1. **중복 제거**

```ruby
class Dollar
  attr_accessor :amount
  def initialize(amount)
	@amount = amount
  end
  def times(multiplier)
	self.amount *= multiplier
  end
end

```

## 정리

1. 테스트 목록 만들기
2. 오퍼레이션이 어떻게 보이길 원하는지를 코드로 작성
3. 스텝 구현을 통해 테스트 컴파일
4. 테스트 통과
5. 수정
6. 중복제거 
7. 되풀이