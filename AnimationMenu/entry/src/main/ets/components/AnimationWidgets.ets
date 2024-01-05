import CommonConst from '../common/Const';
import IconModel, { IconItem } from '../viewmodel/IconViewModel';
import IconAnimation from './IconAnimation';

@Component
export default struct AnimationWidgets {
  @State mainFlag: boolean = false;
  @Link @Watch('onQuantityChange') quantity: number;
  @Consume iconModel: IconModel;

  onQuantityChange() {
    this.iconModel.addImage(this.quantity);
  }

  animate() {
    animateTo(
      {
        delay: 10,
        tempo: 0.68,
        iterations: 1,
        duration: 500,
        curve: Curve.Smooth,
        playMode: PlayMode.Normal
      }, () => {
      this.mainFlag = !this.mainFlag;
    })
  }

  aboutToAppear() {
    this.onQuantityChange();
  }

  build() {
    Stack() {
      Stack() {
        ForEach(this.iconModel.imagerArr, (item: IconItem) => {
          IconAnimation({
            item: item,
            mainFlag: this.mainFlag
          })
        }, (item: IconItem) => JSON.stringify(item.index))
      }
      .width('100%')
      .height('100%')
      .rotate({
        x: 0,
        y: 0,
        z: 1,
        angle: this.mainFlag ? CommonConst.ROTATE_ANGLE_360 : 0
      })

      Image(this.mainFlag ? $r('app.media.imgActive') : $r('app.media.imgInit'))
        .width(64)
        .height(64)
        .objectFit(ImageFit.Contain)
        .scale({
          x: this.mainFlag ? CommonConst.INIT_SCALE : 1,
          y: this.mainFlag ? CommonConst.INIT_SCALE : 1
        })
        .onClick(() => {
          this.iconModel.reset();
          this.animate();
        })

      Text('请点击按钮')
        .fontSize(16)
        .opacity(0.6)
        .fontColor('#182431')
        .fontWeight(500)
        .margin({
          top: 100
        })
    }
    .width('100%')
    .layoutWeight(1)
  }
}
