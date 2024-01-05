import CommonConst from '../common/Const';
import { IconItem } from '../viewmodel/IconViewModel';

@Component
export default struct IconAnimation {
  @Prop mainFlag: boolean;
  @ObjectLink item: IconItem;

  build() {
    Image(this.item.image)
      .width(CommonConst.ICON_WIDTH)
      .height(CommonConst.ICON_HEIGHT)
      .objectFit(ImageFit.Contain)
      .translate(
        this.mainFlag
          ? { x: this.item.point.x, y: this.item.point.y }
          : { x: 0, y: 0 }
      )
      .rotate({
        x: 0,
        y: 1,
        z: 0,
        angle: this.item.clicked ? CommonConst.ROTATE_ANGLE_360 : 0
      })
      .scale(
        this.item.clicked
          ? { x: CommonConst.SCALE_RATIO, y: CommonConst.SCALE_RATIO }
          : { x: 1, y: 1 }
      )
      .opacity(this.item.clicked ? 0.6 : 1)
      .onClick(() => {
        this.item.clicked = !this.item.clicked;
      })
      .animation(
        {
          delay: 10,
          duration: 1000,
          iterations: 1,
          curve: Curve.Smooth,
          playMode: PlayMode.Normal
        }
      )
  }
}