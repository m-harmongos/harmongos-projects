import display from '@ohos.display'
import CommonConstants from '../common/CommonConstants'
import DimensionUtil from '../common/DimensionUtil'
import GlobalContext from '../common/GlobalContext'
import RefreshComponent from '../components/RefreshComponent'
import { RefreshConstants, RefreshHeaderStyle, RefreshState } from '../components/RefreshConstants'

@Entry
@Component
struct Index {
  private deviceDisplay: display.Display = GlobalContext.getContext().getObject('display') as display.Display;
  @Provide(RefreshConstants.REFRESH_STATE_TAG) state: RefreshState = RefreshState.REFRESHING;
  @State message: string = 'Hello World'

  @Builder
  contentBody() {
    Image($r('app.media.icon'))
      .width(CommonConstants.FULL_HEIGHT)
      .height(DimensionUtil.getVp(626))
      .objectFit(ImageFit.Fill)
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Text('Cloud space')
        .backgroundColor(Color.White)
        .width(CommonConstants.FULL_HEIGHT)
        .height(DimensionUtil.getVp(56))
        .fontSize(DimensionUtil.getFp(20))
        .fontWeight(FontWeight.Regular)
        .padding({ left: DimensionUtil.getVp(24) })
        .zIndex(1)
      RefreshComponent({
        headerStyle: RefreshHeaderStyle.CLOUD,
        itemLayout: () => this.contentBody(),
        displayHeight: px2vp(this.deviceDisplay.height - DimensionUtil.getVp(56)),
        onRefresh: () => {
          setTimeout(() => {
            this.state = RefreshState.COMPLETE;
          }, 6000)
        }
      })
        .width(CommonConstants.FULL_HEIGHT)
        .margin({ top: DimensionUtil.getVp(56)})
    }
    .height(CommonConstants.FULL_HEIGHT)
  }
}