import { DetailConstant } from '../../../common/CommonConstants';
import AlarmItem from '../../../viewmodel/AlarmItem';
import CommonDialog from './CommonDialog';

@CustomDialog
export default struct RenameDialog {
  @Consume(DetailConstant.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;
  private name: string = '';
  controller: CustomDialogController
  //   = new CustomDialogController({
  //   builder: RenameDialog(),
  //   autoCancel: true,
  // });

  build() {
    Flex() {
      CommonDialog({
        title: '闹钟名',
        controller: this.controller,
        onConfirm: () => {
          this.alarmItem.name = this.name;
        }
      }) {
        TextArea({ text: this.alarmItem.name })
          .width('100%')
          .margin({ bottom: 20 })
          .onChange((value: string) => {
            this.name = value;
          })
        Divider()
          .opacity(0.05)
          .color('#182431')
          .lineCap(LineCapStyle.Round)
      }
    }
  }
}