@Component
export default struct CommonDialog {
  private title?: string | Resource;
  private controller?: CustomDialogController;
  private onConfirm: () => void = () => {};
  // 类似插槽
  @BuilderParam closer: () => void = () => {};

  build() {
    Column() {
      Text(this.title)
        .fontSize(20)
        .width('100%')
        .fontColor('#182431')
        .margin({
          bottom: 12
        })
      this.closer()
      Row() {
        Button('取消').actionBtnStyle().onClick(() => {
          if (!this.controller) {
            return;
          }
          this.controller.close();
        })
        if (this.onConfirm) {
          Button('确定').actionBtnStyle().onClick(() => {
            this.onConfirm();
            if (!this.controller) {
              return;
            }
            this.controller.close();
          })
        }
      }
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.Center)
  }
}

@Extend(Button)
function actionBtnStyle() {
  .fontSize(15)
  .height(40)
  .layoutWeight(1)
  .fontColor('#17A98e')
  .backgroundColor('#00000000')
}