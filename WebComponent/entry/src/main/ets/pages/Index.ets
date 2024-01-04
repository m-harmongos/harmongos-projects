import router from '@ohos.router';
import webview from '@ohos.web.webview';
import prompt from '@ohos.prompt';
@Entry
@Component
struct Index {
  @State progressVal: number = 0;
  @State isLoading: boolean = true;
  // 加载进度条
  @State intervalLoading: number = -1;
  @State params: object = router.getParams();
  webController: webview.WebviewController = new webview.WebviewController();

  aboutToAppear() {
    this.intervalLoading = setInterval(() => {
      this.progressVal = this.progressVal >= 100 ? 0 : (this.progressVal + 10);
    }, 100);
  }

  @Builder Nav() {
    Row() {
      Image($rawfile('img/ic_public_back.png'))
        .width(24)
        .height(24)
        .margin({ left: '7.2%' })
        .onClick(() => {
          router.back()
        })
      Text('Sweepstakes App')
        .fontSize(20)
        .fontColor('#000000')
        .margin({ left: '5%' })
    }
    .height('7.2%')
    .alignSelf(ItemAlign.Start)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Image($r('app.media.background')).width('100%').height('38.7%')
      Row() {
        Column() {
          this.Nav()
          Web({ src: this.params['path'], controller: this.webController })
            .zoomAccess(false)
            .width('93.3%')
            .backgroundColor(Color.White)
            .aspectRatio(1)
            .margin({ left: 16, right: 16, top: 16 })
            .onConfirm((event) => {
              AlertDialog.show({
                message: '恭喜您抽中:' + event?.message,
                confirm: {
                  value: 'Confirm',
                  action: () => {
                    event?.result.handleConfirm();
                  }
                },
                cancel: () => {
                  event?.result.handleCancel();
                }
              });
              return true;
            })
            .onErrorReceive((event) => {
              if (event?.error.getErrorInfo() === 'ERR_INTERNET_DISCONNECTED') {
                prompt.showToast({
                  message: 'Failed to load the network',
                  duration: 3000
                })
              }
              if (event?.error.getErrorInfo() === 'ERR_CONNECTION_TIMED_OUT') {
                prompt.showToast({
                  message: 'Failed to load the network.',
                  duration: 3000
                })
              }
            })
            .onProgressChange((event) => {
              if (event?.newProgress === 100) {
                this.isLoading = false;
                clearInterval(this.intervalLoading);
                this.intervalLoading = -1;
              }
            })

          Button('Click on the raffle')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .margin({ top: 20 })
            // .width(Const.WebConstant_BUTTON_WIDTH)
            .height(30)
            .backgroundColor('#007DFF')
            .borderRadius(20)
            .onClick(() => {
              this.webController.runJavaScript('startDraw()');
            })
        }
        .width('100%')
        .height('100%')
      }
      if (this.isLoading) {
        Progress({
          value: 0,
          total: 100,
          type: ProgressType.ScaleRing
        })
          .color(Color.Grey)
          .value(this.progressVal)
          .width(80)
          .style({
            strokeWidth: 15,
            scaleCount: 15,
            scaleWidth: 5
          })
          .zIndex(1)
          .position({
            x: '40%',
            y: '30%'
          })
      }
    }
    .backgroundColor('#F1F3F5')
  }
}