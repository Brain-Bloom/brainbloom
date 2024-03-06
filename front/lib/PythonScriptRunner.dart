import 'package:process_run/process_run.dart';


Future<String> runPythonScript(String arg1, String arg2, String arg3) async {
  if (arg3 == ""){
    arg3 = "no_link_provided";
  }
  var result = await run('python lib/python_script/telechargement.py $arg1 $arg2 $arg3');
  return result.outText;
}