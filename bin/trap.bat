@rem Call ruby with the full path of this batch script's directory plus '\trap'
@rem which is the Ruby script for Trapeze.
@ruby "%~dp0trap" "%1" "%2"
