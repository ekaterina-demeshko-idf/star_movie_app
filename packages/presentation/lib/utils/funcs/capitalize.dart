String capitalize(String? s) {
  if(s == null) { return 'Err'; }
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}

