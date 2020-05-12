#!/bin/ruby
# frozen_string_literal: true

require 'json'
require 'stringio'

#
# Complete the 'get_user_transaction' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts following parameters:
#  1. INTEGER uid
#  2. STRING txn_type
#  3. STRING month_year
#
#  https://jsonmock.hackerrank.com/api/transactions/search?txnType=
#

def get_user_transaction(uid, txn_type, month_year)
  # Write your code here
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

uid = gets.strip.to_i

txn_type = gets.chomp

month_year = gets.chomp

result = get_user_transaction(uid, txn_type, month_year)

fptr.write result.join "\n"
fptr.write "\n"

fptr.close
