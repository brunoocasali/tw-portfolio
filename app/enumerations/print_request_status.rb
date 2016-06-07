class PrintRequestStatus < EnumerateIt::Base
  associate_values :requested, :processed, :confirmed, :finished, :waiting_payment
end
