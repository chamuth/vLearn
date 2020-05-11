String ellipsis(String long, int length)
{
  if (long.length > length)
    return long.substring(0, length) + "...";
  else return long;
}