

export class innerParam {
  array:number[];

  constructor(tuple: number[]) {
    this.array = tuple;
  }

   toString() :string {
     // let str:string = '';
     // this.array.forEach((i) => {
     //  str += i + ", "
     // })

     return "1111"
   }
}


export class RouterParam{
  text:string
  data:innerParam

  constructor(text: string, tuple: number[]) {
    this.text = text;
    this.data = new innerParam(tuple);
  }
}