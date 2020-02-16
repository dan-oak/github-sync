.[] | select(
  .archived == false
    and
  .disabled == false
) |
  .name
