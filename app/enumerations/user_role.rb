class UserRole < EnumerateIt::Base
  associate_values admin: 1, client: 2, print_requestor: 3
end
