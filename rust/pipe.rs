use std::process::Command;

fn exec(cmd: &str, args: &[&str]) -> String
{
   let output = Command::new(cmd)
   .args(args)
   .output()
   .expect("failed to execute cmd");

   String::from_utf8(output.stdout).unwrap()
}

fn main() {
    let ret = exec("sh", &["-c", "ip addr |grep global"]);
    //let ret = exec("sh", &["-c", "ls -l |grep target"]);
    println!("exec: <{}>", ret);
}