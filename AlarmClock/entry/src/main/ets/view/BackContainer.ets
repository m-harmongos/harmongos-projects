import router from '@ohos.router';
@Component
export default struct BackContainer {
  private header: string = '新建闹钟';
  private backImageRes: string | Resource = $r('app.media.ic_cancel');
  private backFunc?: () => void;
  @BuilderParam closer?: () => void;

  build() {
    Row() {
      Button() {
        Image(this.backImageRes ? this.backImageRes : $r('app.media.ic_public_back')).objectFit(ImageFit.Fill)
      }
      .backgroundColor('#00000000')
      .width(24)
      .height(24)
      .onClick(() => {
        this.backFunc ? this.backFunc() : router.back();
      })

      Text(this.header)
        .fontSize(20)
        .lineHeight(28)
        .margin({ left: 16 })
        .fontColor('#182431')
        .fontWeight(FontWeight.Bold)

      Blank()

      if (this.closer) {
        this.closer()
      }
    }
    .padding({ left: 24, right: 24 })
    .width('100%')
    .height(56)
  }
}