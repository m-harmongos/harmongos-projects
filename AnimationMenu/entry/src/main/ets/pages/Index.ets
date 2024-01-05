import CommonConst from '../common/Const';
import AnimationWidgets from '../components/AnimationWidgets';
import CountController from '../components/CountController';
import IconsModel from '../viewmodel/IconViewModel';

@Entry
@Component
struct Index {
  @State quantity: number = CommonConst.IMAGES_MIN; // 3
  @Provide iconModel: IconsModel = new IconsModel(this.quantity, CommonConst.OFFSET_RADIUS); // 145

  build() {
    Column() {
      AnimationWidgets({ quantity: $quantity })

      CountController({ quantity: $quantity })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f1f3f5')
  }
}