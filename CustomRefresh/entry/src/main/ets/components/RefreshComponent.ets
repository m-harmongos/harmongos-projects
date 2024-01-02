import RefreshAnimHeader from './RefreshAnimHeader';
import { RefreshConstants, RefreshHeaderStyle, RefreshState } from './RefreshConstants';
import RefreshDefaultHeader from './RefreshDefaultHeader';

@Component
export default struct RefreshComponent {
  private listController: Scroller = new Scroller();
  // header默认样式
  private headerStyle: RefreshHeaderStyle = RefreshHeaderStyle.DEFAULT;
  // header高度
  private displayHeight: number = 0;
  // 刷新事件
  private onRefresh?: () => void;
  // item
  @BuilderParam itemLayout?: () => void;
  // haeder偏移
  @State headerOffset: number = 0;
  @Consume(RefreshConstants.REFRESH_STATE_TAG) @Watch('onStateChange') state: RefreshState;

  private onStateChange() {
    switch (this.state) {
      case RefreshState.REFRESHING:
        if (!this.onRefresh) {
          this.onRefresh();
        }
        break;
      case RefreshState.COMPLETE:
        this.headerOffset = -RefreshConstants.REFRESH_HEADER_HEIGHT;
        break;
    }
  }

  aboutToAppear() {
    if (this.state === RefreshState.REFRESHING) {
      this.headerOffset = 0;
      this.onStateChange();
    } else {
      this.state = RefreshState.IDLE;
      this.headerOffset = -RefreshConstants.REFRESH_HEADER_HEIGHT;
    }
    this.displayHeight = RefreshConstants.REFRESH_HEADER_HEIGHT + this.displayHeight;
  }

  build() {
    List({ scroller: this.listController }) {
      ListItem() {
        Column() {
          if (this.headerStyle === RefreshHeaderStyle.DEFAULT) {
            RefreshDefaultHeader().height(RefreshConstants.REFRESH_HEADER_HEIGHT)
          } else if (this.headerStyle === RefreshHeaderStyle.CLOUD) {
            RefreshAnimHeader().height(RefreshConstants.REFRESH_HEADER_HEIGHT)
          }
          if (!this.itemLayout) {
            this.itemLayout()
          }
        }
        .width('100%')
        .height(Number(this.displayHeight) + RefreshConstants.REFRESH_LAYOUT_EXTRA_HEIGHT)
      }
    }
  }
}