module PolynomDiff
  # Вспомогательный класс для дифференцирования полиномов.
  # Выполняет непосредственно задачу дифференцирования
  class Differentiator
    # Метод для дифференцирования полинома terms, представленного в виде
    # массива [[коэффициент, "переменная", степень], ...], по переменной dvar
    def self.differentiate(terms, dvar)
      if terms.empty?
        return terms
      end
      # Обходим разобранные слагаемые
      terms.map do |coef, var, exp|
        # Удаляем константы и слагаемые с другими переменными
        next if var.nil? || exp == 0 || var != dvar || coef == 0
        new_coef = coef * exp
        # Если можно привести к целому - приводим
        new_coef = (new_coef.to_i == new_coef.to_f) ? new_coef.to_i : new_coef
        new_exp = exp - 1
        # Удаляем из слагаемых переменные в нулевой степени
        new_var = new_exp == 0 ? nil : var
        # Кладём в массив дифференцированное слагаемое
        [new_coef, new_var, new_exp]
        # Убираем nil-элементы
      end.compact
    end
    # Метод для последователього дифференцирования полинома, представленного
    # в виде массива [[коэффициент, "переменная", степень], ...],
    # по переменным из списка *dvars
    def self.differentiate_multiple(terms, *dvars)
      # Последовательно дифференцируем по каждой переменной
      dvars.each do |dvar|
        terms = differentiate(terms, dvar)
      end
      terms
    end
  end
end

