class UserRole < EnumerateIt::Base
  associate_values :admin, :client, :print_requestor
end
