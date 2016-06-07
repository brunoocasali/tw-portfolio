class SessionStatus < EnumerateIt::Base
  associate_values :waiting, :finished, :canceled
end
