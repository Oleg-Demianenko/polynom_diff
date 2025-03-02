module PolynomDiff
  # Класс для дифференцирования полиномов
  # Обращается к другим вспомогательным классам: Parser, Differentiator, PolynomToString
  class Diff
    # Медот для дифференцирования полиномов
    # Принимает полиномы строковом представлении вида “x^2+4*x+3+y” и возвращает строковый результат вида “2*x+4”
    # Также принимает полином в качестве массива [[коэффициент, "переменная", степень], ...]
    # Для последовательного дифференцирования переменные в параметр *variables передаются списком.
    # Параметр format: true - вернуть полином в виде строки: false - вернуть полином в виде массива
    def self.Diff(polynomial, *variables, format: true)
      # Если получили строку - парсим
      terms = polynomial.is_a?(String) ? Parser.parse(polynomial) : polynomial
      # Дифференцируем
      result = Differentiator.differentiate_multiple(terms, *variables)
      # Если требуется, переводим полином в строку
      format ? PolynomToString.ToString(result) : result
    end
  end
end

