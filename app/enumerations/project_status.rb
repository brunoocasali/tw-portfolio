class ProjectStatus < EnumerateIt::Base
  associate_values :working, :waiting_payment, :lauched
end
