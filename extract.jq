.[] | select(
  .archived? == false
    and
  .disabled? == false
    and
  .size > 0
) |
  .name
