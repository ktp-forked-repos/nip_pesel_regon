module NipPeselRegon
  module Validator
    class Regon9 < Abstract
      WEIGHTS = [8, 9, 2, 3, 4, 5, 6, 7]

      PATTERN = /^\d{9}$/

      def validate
        mod = calculate_sum % 11

        # if mod is equal to 10 then set it to 0
        mod = 0 if mod == 10

        # compare mod with last digit
        mod == number[-1].to_i
      end

    end
  end
end

