require "polynom_diff/parser"
# Тесты для парсера
RSpec.describe PolynomDiff::Parser do
  it "1.1 парсит пустой полином" do
    expect(PolynomDiff::Parser.parse("")).to eq([])
  end
  it "1.2 парсит одно число" do
    expect(PolynomDiff::Parser.parse("5")).to eq([[5, nil, 0]])
  end
  it "1.3 парсит одно число с плавающей точкой" do
    expect(PolynomDiff::Parser.parse("5.17")).to eq([[5.17, nil, 0]])
  end
  it "1.4 парсит одно отрицательное число" do
    expect(PolynomDiff::Parser.parse("-5")).to eq([[-5, nil, 0]])
  end
  it "1.5 парсит одно отрицательное число с плавающей точкой" do
    expect(PolynomDiff::Parser.parse("-5.17")).to eq([[-5.17, nil, 0]])
  end
  it "1.6 парсит ноль" do
    expect(PolynomDiff::Parser.parse("0")).to eq([])
  end

  it "1.7 парсит одно слагаемое" do
    expect(PolynomDiff::Parser.parse("4x")).to eq([[4, "x", 1]])
  end
  it "1.8 парсит одно слагаемое" do
    expect(PolynomDiff::Parser.parse("4*x")).to eq([[4, "x", 1]])
  end
  it "1.9 парсит одно слагаемое с плавающей точкой" do
    expect(PolynomDiff::Parser.parse("4.76x")).to eq([[4.76, "x", 1]])
  end
  it "1.10 парсит одно слагаемое с плавающей точкой" do
    expect(PolynomDiff::Parser.parse("4.76*x")).to eq([[4.76, "x", 1]])
  end
  it "1.11 парсит одно отрицательное слагаемое" do
    expect(PolynomDiff::Parser.parse("-4x")).to eq([[-4, "x", 1]])
  end
  it "1.12 парсит одно отрицательное слагаемое" do
    expect(PolynomDiff::Parser.parse("-4*x")).to eq([[-4, "x", 1]])
  end
  it "1.13 парсит одно отрицательное слагаемое с плавающей точкой" do
    expect(PolynomDiff::Parser.parse("-4.76x")).to eq([[-4.76, "x", 1]])
  end
  it "1.14 парсит одно отрицательное слагаемое с плавающей точкой" do
    expect(PolynomDiff::Parser.parse("-4.76*x")).to eq([[-4.76, "x", 1]])
  end

  it "1.15 парсит одно слагаемое в степени 0" do
    expect(PolynomDiff::Parser.parse("4x^0")).to eq([[4, nil, 0]])
  end
  it "1.16 парсит одно слагаемое в степени 0" do
    expect(PolynomDiff::Parser.parse("4*x^0")).to eq([[4, nil, 0]])
  end
  it "1.17 парсит одно отрицательное слагаемое в степени 0" do
    expect(PolynomDiff::Parser.parse("-4x^0")).to eq([[-4, nil, 0]])
  end
  it "1.18 парсит одно отрицательное слагаемое в степени 0" do
    expect(PolynomDiff::Parser.parse("-4*x^0")).to eq([[-4, nil, 0]])
  end

  it "1.19 парсит одно отрицательное слагаемое в отрицательной степени" do
    expect(PolynomDiff::Parser.parse("-4*x^-2")).to eq([[-4, "x", -2]])
  end
  it "1.20 парсит одно отрицательное слагаемое в отрицательной степени" do
    expect(PolynomDiff::Parser.parse("-4*x^(-2)")).to eq([[-4, "x", -2]])
  end
  it "1.21 парсит одно отрицательное слагаемое с плавающей точкой в отрицательной степени с плавающей точкой" do
    expect(PolynomDiff::Parser.parse("-4.12*x^-2.25")).to eq([[-4.12, "x", -2.25]])
  end
  it "1.22 парсит одно отрицательное слагаемое с плавающей точкой в отрицательной степени с плавающей точкой" do
    expect(PolynomDiff::Parser.parse("-4.12*x^(-2.25)")).to eq([[-4.12, "x", -2.25]])
  end

  it "1.23 парсит полином" do
    expect(PolynomDiff::Parser.parse("3x^2 - 4x + 5")).to eq([[3, "x", 2], [-4, "x", 1], [5, nil, 0]])
  end
  it "1.24 парсит полином" do
    expect(PolynomDiff::Parser.parse("3*x^2 - 4x + 5")).to eq([[3, "x", 2], [-4, "x", 1], [5, nil, 0]])
  end
  it "1.25 парсит полином" do
    expect(PolynomDiff::Parser.parse("3x^2 - 4*x + 5")).to eq([[3, "x", 2], [-4, "x", 1], [5, nil, 0]])
  end
  it "1.26 парсит полином" do
    expect(PolynomDiff::Parser.parse("3*x^-2 - 4*x + 5")).to eq([[3, "x", -2], [-4, "x", 1], [5, nil, 0]])
  end
  it "1.27 парсит полином" do
    expect(PolynomDiff::Parser.parse("3*x^(-2) - 4*x + 5")).to eq([[3, "x", -2], [-4, "x", 1], [5, nil, 0]])
  end

  it "1.28 парсит полином посложнее" do
    expect(PolynomDiff::Parser.parse("3.191*x^(-2.17) + 11y^(9148.241) - 45.8*x - 0.0012y^(-146.1)
+ x^(-6) - y^-12 + 15x^-3.51  + 5")).to eq([[3.191, "x", -2.17], [11, "y", 9148.241], [-45.8, "x" , 1],
                                            [-0.0012, "y", -146.1], [1, "x", -6] , [-1, "y", -12], [15, "x", -3.51],
                                            [5, nil, 0]])
  end
end

require "polynom_diff/differentiator"
# Тесты для дифференцирования
RSpec.describe PolynomDiff::Differentiator do
  it "2.1 дифференцирует пустой массив" do
    terms = []
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([])
  end

  it "2.2 дифференцирует массив с нулём" do
    terms = [[0, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([])
  end
  it "2.3 дифференцирует массив с неявным нулём" do
    terms = [[0, "x", 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([])
  end
  it "2.3 дифференцирует массив с неявным нулём" do
    terms = [[0, "x", 2]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([])
  end
  it "2.4 дифференцирует массив с константой" do
    terms = [[1, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([])
  end
  it "2.5 дифференцирует массив с константой" do
    terms = [[1.2, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([])
  end
  it "2.6 дифференцирует массив с неявной константой" do
    terms = [[1, "x", 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([])
  end
  it "2.7 дифференцирует массив с неявной константой" do
    terms = [[1.2, "x", 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([])
  end

  it "2.8 дифференцирует массив" do
    terms = [[3, "x", 2], [-4, "x", 1], [5, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([[6, "x", 1], [-4, nil, 0]])
  end
  it "2.9 дифференцирует массив" do
    terms = [[3.17, "x", 2], [-4, "x", 1.5], [5, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([[6.34, "x", 1], [-6, "x", 0.5]])
  end
  it "2.10 дифференцирует массив" do
    terms = [[3.17, "x", 2], [-4, "x", -1.5], [5, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([[6.34, "x", 1], [6, "x", -2.5]])
  end
  it "2.11 дифференцирует массив с разными переменными" do
    terms = [[3, "x", 2], [-4, "x", 1], [5, "y", -0.4], [8, "z", 0.25], [5, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate(terms, "x")).to eq([[6, "x", 1], [-4, nil, 0]])
  end

  it "2.12 дифференцирует по нескольким переменным" do
    terms = [[3, "x", 2], [2, "y", 1], [5, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate_multiple(terms, "x", "y")).to eq([])
  end
  it "2.13 дифференцирует несколько раз по одной переменной" do
    terms = [[3, "x", 2], [2, "y", 1], [5, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate_multiple(terms, "x", "x")).to eq([[6, nil, 0]])
  end

  it "2.13 дифференцирует несколько раз по одной переменной" do
    terms = [[3, "x", 2], [2, "y", -0.5], [5, nil, 0]]
    expect(PolynomDiff::Differentiator.differentiate_multiple(terms, "y", "y")).to eq([[1.5, "y", -2.5]])
  end
end


require "polynom_diff/polynomtostring"
# Тесты для перевода полинома из массива в строку
RSpec.describe PolynomDiff::PolynomToString do
  it "3.1 собирает массив в строку" do
    terms = [[1, "x", 2], [6, "x", 1], [-4, nil, 0]]
    expect(PolynomDiff::PolynomToString.ToString(terms)).to eq("x^2+6*x-4")
  end

  it "3.2 собирает массив с одним лишним нулём в строку" do
    terms = [[1, "x", 2], [6, "x", 1], [0, "x", 12], [-4, nil, 0]]
    expect(PolynomDiff::PolynomToString.ToString(terms)).to eq("x^2+6*x-4")
  end

  it "3.3 собирает массив с одним лишним нулём и десятичными коэффициентами в строку" do
    terms = [[1.2, "x", 2.57], [6, "x", -1.6], [0, "x", 12], [-4.19, nil, 0]]
    expect(PolynomDiff::PolynomToString.ToString(terms)).to eq("1.2*x^2.57+6*x^(-1.6)-4.19")
  end

  it "3.4 собирает массив с несколькими переменными в строку" do
    terms = [[3, "x", 2], [2, "y", 1], [-5, nil, 0]]
    expect(PolynomDiff::PolynomToString.ToString(terms)).to eq("3*x^2+2*y-5")
  end
end

require "polynom_diff/diff"
# Тесты для полного цикла операций
RSpec.describe PolynomDiff::Diff do
  it "4.1 парсит и дифференцирует" do
    expect(PolynomDiff::Diff::Diff("3x^2 - 4x + 5", "x")).to eq("6*x-4")
  end
  it "4.2 парсит и дифференцирует пустую строку" do
    expect(PolynomDiff::Diff::Diff("", "x")).to eq("")
  end

  it "4.3 дифференцирует массив входных данных" do
    terms = [[3, "x", 2], [-4, "x", 1], [5, "y", -0.4], [8, "z", 0.25], [5, nil, 0]]
    expect(PolynomDiff::Diff.Diff(terms, "x")).to eq("6*x-4")
  end
  it "4.4 дифференцирует пустой массив входных данных" do
    terms = []
    expect(PolynomDiff::Diff.Diff(terms, "x")).to eq("")
  end
end



