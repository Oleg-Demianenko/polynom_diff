module PolynomDiff
  # Парсер для полинома в строковом представлении
  class Parser
    # Метод для перевода полинома из строкового представления
    # в массив вида [[коэффициент, "переменная", степень], ...]
    def self.parse(polynomial)
      # На вход должна подаваться строка
      if polynomial.is_a?(String)
        # Слагаемые сохраняются в массиве
        terms = []
        # Удалим из выражения пробелы
        polynomial.gsub!(" ", "")
        # Выделяем слагаемые при помощи регулярного выражения и обходим их
        polynomial.scan(/([+-]?\d*(?:\.\d+)?\*?)([a-zA-Z]?)(?:\^\(?(-?\d+(?:\.\d+)?)\)?)?/).each do |coef, var, exp|
          # Обработаем коэффициент
          next if coef.empty? && var.empty? || coef == 0
          case coef
          when "+"
            coef = 1
          when "-"
            coef = -1
          when ""
            coef = 1
          else
            # Если можно сразу привести к целому - приводим
            coef = (coef.to_i == coef.to_f) ? coef.to_i : coef.to_f
          end
          # Обработаем показатель степени
          if exp.nil?
            if var.empty?
              exp = 0
            else
              exp = 1
            end
          else
            # Если можно сращу привести к целому - приводим
            exp = (exp.to_i == exp.to_f) ? exp.to_i : exp.to_f
          end
          # Обработаем саму переменную
          if var.empty? || exp == 0
            var = nil
          end
          # Записываем слагаемое в массив
          if coef != 0
            terms << [coef, var, exp]
          end
        end
        return terms
        end
      end
  end
end
