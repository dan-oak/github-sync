.[] | select(
  .archived == false
    and
  .disabled == false
    and
  .size > 0
    and
  .fork == false
) |
  .name
