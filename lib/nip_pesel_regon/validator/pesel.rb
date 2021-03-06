module NipPeselRegon
  module Validator

    # Class responsible for
    # PESEL validation.
    class Pesel < Base
      # array with weights
      # last digit is 1 - it's not official weight but
      # it will help to calculate all checksum like: a+3b+7c+9d+e+3f+7g+9h+i+3j+k
      # en - https://en.wikipedia.org/wiki/PESEL
      # pl - https://pl.wikipedia.org/wiki/PESEL
      WEIGHTS = [1, 3, 7, 9, 1, 3 ,7, 9, 1, 3, 1].freeze

      # pattern for PESEL
      PATTERN = /^\d{11}$/

      private

      # Main validation method.
      def validate
        checksum % 10 == 0
      end

    end
  end
end
