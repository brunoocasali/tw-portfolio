class ProjectStatus < EnumerateIt::Base
  associate_values working: 1, waiting_payment: 2, launched: 3, initiated: 4
end
