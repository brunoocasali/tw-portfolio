class SessionStatus < EnumerateIt::Base
  associate_values canceled: 0, waiting: 1, finished: 2
end
