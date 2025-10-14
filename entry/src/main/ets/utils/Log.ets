export class Log {
  static TAG: string = "yaowen";


  static i(content: string | number) {
    console.log(Log.TAG, content);
  }
}