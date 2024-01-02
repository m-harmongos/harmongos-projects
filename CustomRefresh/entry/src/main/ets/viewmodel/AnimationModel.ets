export default class ClassifyModel {
  imgRes: Resource;
  posX: number;
  delay: number;

  constructor(imgRes: Resource, posX: number, delay: number) {
    this.imgRes = imgRes;
    this.posX = posX;
    this.delay = delay;
  }
}