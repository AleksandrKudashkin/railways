fibonaccies = [0, 1]
while fibonaccies[-2] + fibonaccies[-1] < 100 do
  fibonaccies << fibonaccies[-2] + fibonaccies[-1]
end

puts fibonaccies