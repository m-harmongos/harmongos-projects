import display from '@ohos.display';
import GlobalContext from './GlobalContext';

let context = getContext(this);

const DESIGN_WIDTH = 360;
const DESIGN_HEIGHT = 780;

export default class DimensionUtil {
  static adaptDimension(value: number): number {
    let deviceDisplay: display.Display = GlobalContext.getContext().getObject('display') as display.Display;
    let widthScale = deviceDisplay.width / DESIGN_WIDTH;
    let virtualHeight = widthScale * DESIGN_HEIGHT;
    let designDim = Math.sqrt(DESIGN_WIDTH * DESIGN_WIDTH + DESIGN_HEIGHT * DESIGN_HEIGHT);
    let virtualDim = Math.sqrt(deviceDisplay.width * deviceDisplay.width + virtualHeight * virtualHeight);
    return virtualDim * value / designDim;
  }

  // 转px
  static getPx(value: Resource|number):number {
    if (typeof value === 'number') {
      return DimensionUtil.adaptDimension(value);
    }
    let beforeVp = context.resourceManager.getNumber(value.id);
    return DimensionUtil.adaptDimension(beforeVp);
  }

  static getVp(value: Resource|number): number {
    if (typeof value === 'number') {
      return px2vp(DimensionUtil.adaptDimension(value));
    }
    let beforeVp = context.resourceManager.getNumber(value.id);
    return px2vp(DimensionUtil.adaptDimension(beforeVp));
  }

  static getFp(value: Resource|number): number {
    if (typeof value === 'number') {
      return px2fp(DimensionUtil.adaptDimension(value));
    }
    let beforeVp = context.resourceManager.getNumber(value.id);
    return px2fp(DimensionUtil.adaptDimension(beforeVp));
  }
}