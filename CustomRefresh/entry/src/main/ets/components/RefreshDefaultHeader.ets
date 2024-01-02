import DimensionUtil from '../common/DimensionUtil';
import { RefreshConstants, RefreshHeaderConstants, RefreshState } from './RefreshConstants';

@Component
export default struct RefreshDefaultHeader {
  @State refreshTitle: string = 'Pull Down Refresh'
  @Consume(RefreshConstants.REFRESH_STATE_TAG) @Watch('onStateCheck') state: number;

  private onStateCheck() {
    switch (this.state) {
      case RefreshState.IDLE:
        this.refreshTitle = RefreshHeaderConstants.DEFAULT_HEADER_HINT;
        break;
      case RefreshState.DRAGGING_REFRESHABLE:
        this.refreshTitle = RefreshHeaderConstants.DEFAULT_HEADER_LOAD;
        break;
      case RefreshState.REFRESHING:
        this.refreshTitle = RefreshHeaderConstants.DEFAULT_HEADER_REFRESHING;
        break;
    }
  }

  build() {
    if (this.state !== RefreshState.IDLE) {
      Text(this.refreshTitle)
        .height('100%')
        .width('100%')
        .textAlign(TextAlign.Center)
        .fontSize(DimensionUtil.getFp(16))
        .onAppear(() => {
          this.onStateCheck();
        })
    }
  }
}