import CommonConst from '../common/Const';

// 2TT
const TWO_PI: number = 2 * Math.PI;

export class Point {
  public x: number = 0;
  public y: number = 0;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Observed
export class IconItem {
  index: number = 0;
  clicked: boolean = false;
  image: Resource = $r('app.media.badge1');
  point: Point = new Point(0, 0);

  constructor(index: number, image: Resource, clicked: boolean, point: Point) {
    this.index = index;
    this.image = image;
    this.clicked = clicked;
    this.point = point;
  }
}

@Observed
export default class IconViewModel {
  public imagerArr: Array<IconItem> = [];
  private num: number = CommonConst.IMAGES_MIN; // 3
  private radius: number;

  constructor(num: number, radius: number) {
    this.radius = radius;
    this.addImage(num);
  }

  public addImage(num: number) {
    this.num = num;
    if (this.imagerArr.length === num) {
      return;
    }
    if (this.imagerArr.length > num) {
      this.imagerArr.splice(num, this.imagerArr.length - num);
    } else {
      for (let i = this.imagerArr.length; i < num; i++) {
        const point = this.genPointByIndex(i);
        this.imagerArr.push(new IconItem(i, CommonConst.IMAGE_RESOURCE[i], false, point));
      }
    }

    this.refreshPoint(num);
  }

  public refreshPoint(num: number) {
    for (let i = 0; i < num; i++) {
      this.imagerArr[i].point = this.genPointByIndex(i);
    }
  }

  public genPointByIndex(index: number): Point {
    const x = this.radius * Math.cos(TWO_PI * index / this.num);
    const y = this.radius * Math.sin(TWO_PI * index / this.num);
    return new Point(x, y);
  }

  public reset() {
    for (let i = 0; i < this.num; i++) {
      if (this.imagerArr[i].clicked) {
        this.imagerArr[i].clicked = false
      }
    }
  }
}