#!/bin/ruby
# frozen_string_literal: true

require 'json'
require 'stringio'

#
# Complete the 'getUserTransaction' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts following parameters:
#  1. INTEGER uid
#  2. STRING txnType
#  3. STRING monthYear
#
#  https://jsonmock.hackerrank.com/api/transactions/search?txnType=
#

require 'net/http'
require 'date'

def avg(transactions)
  return [] if transactions.size.zero?

  debits = transactions.select { |t| t['txnType'] == 'debit' }
  debits.sum { |t| t['amount'] } / debits.size
end

def parsed_get(url)
  JSON.parse(Net::HTTP.get(url))
end

def getUserTransaction(uid, txnType, monthYear)
  p uid
  month, year = monthYear.split('-').map(&:to_i)
  req_url = URI "https://jsonmock.hackerrank.com/api/transactions/search?userId=#{uid}"
  resp = parsed_get(req_url)
  transactions = resp['data']
  total_pages = resp['total_pages']
  (total_pages - 1).times do |i|
    req_url = URI "https://jsonmock.hackerrank.com/api/transactions/search?userId=#{uid}&page=#{i + 2}"
    req = parsed_get(req_url)
    transactions += req['data']
  end
  monthly = transactions.select do |t|
    time = DateTime.strptime(t['timestamp'].to_s, '%Q')
    time.month == month && time.year == year
  end
  monthly.each do |t|
    t['amount'] = t['amount'][1..-1].tr(',', '').to_f
  end
  average = avg(monthly)
  result = monthly.select { |t| t['amount'] > average && t['txnType'] == txnType }.map { |t| t['id'] }
  return [-1] if result.empty?

  result
end

# fptr = File.open(ENV['OUTPUT_PATH'], 'w')

# uid = gets.strip.to_i

# txnType = gets.chomp

# monthYear = gets.chomp

# result = getUserTransaction uid, txnType, monthYear

# fptr.write result.join "\n"
# fptr.write "\n"

# fptr.close
