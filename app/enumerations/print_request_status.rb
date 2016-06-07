class PrintRequestStatus < EnumerateIt::Base
  associate_values requested: 1, processed: 2, confirmed: 3, waiting_payment: 4, finished: 5
end
