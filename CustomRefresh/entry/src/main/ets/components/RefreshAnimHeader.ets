import display from '@ohos.display';
import CommonConstants from '../common/CommonConstants';
import DimensionUtil from '../common/DimensionUtil';
import GlobalContext from '../common/GlobalContext';
import ClassifyModel from '../viewmodel/AnimationModel';
import { RefreshConstants, RefreshState } from './RefreshConstants';

@Component
export default struct RefreshAnimHeader {
  @Consume(RefreshConstants.REFRESH_STATE_TAG) @Watch('onStateCheck') state: number;
  @State iconWidth: number = 30;
  private  deviceDisplay: display.Display = GlobalContext.getContext().getObject('display') as display.Display;
  private headerFutures: ClassifyModel[] = [
    new ClassifyModel($r('app.media.ic_loading_game'), (px2vp(this.deviceDisplay.width) / 2 - 30 / 2) - 100, 400),
    new ClassifyModel($r('app.media.ic_loading_heart'), (px2vp(this.deviceDisplay.width) / 2 - 30 / 2) - 50, 800),
    new ClassifyModel($r('app.media.ic_loading_louder'), px2vp(this.deviceDisplay.width) / 2 - 30 / 2, 1200),
    new ClassifyModel($r('app.media.ic_loading_bag'), (px2vp(this.deviceDisplay.width) / 2 - 30 / 2) + 50, 1600),
    new ClassifyModel($r('app.media.ic_loading_file'), (px2vp(this.deviceDisplay.width) / 2 - 30 / 2) + 100, 2000)
  ];

  private onStateCheck() {
    if (this.state === RefreshState.REFRESHING) {
      this.iconWidth = 80;
    } else {
      this.iconWidth = 30;
    }
  }

  @Builder AttrAnimIcons(iconItem: ClassifyModel) {
    Image(iconItem.imgRes)
      .width(px2vp(DimensionUtil.adaptDimension(this.iconWidth)))
      .position({ x: iconItem.posX })
      .objectFit(ImageFit.Contain)
      .animation({
        duration: 2000,
        tempo: 3.0,
        delay: iconItem.delay,
        curve: Curve.Linear,
        playMode: PlayMode.Alternate,
        iterations: -1
      })
  }

  build() {
    Row() {
      if (this.state !== RefreshState.IDLE) { // stop animation when idle state.
        ForEach(this.headerFutures, (iconItem: ClassifyModel) => {
          this.AttrAnimIcons(iconItem)
        }, (item: ClassifyModel) => JSON.stringify(item))
      }
    }
    .width('100%')
    .height('100%')
    .onAppear(() => {
      this.onStateCheck();
    })
  }
}