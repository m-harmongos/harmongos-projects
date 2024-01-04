
import { DetailConstant } from '../../../common/CommonConstants';
import AlarmItem from '../../../viewmodel/AlarmItem';
import CommonDialog from './CommonDialog';

@CustomDialog
export default struct DurationDialog {
  @Consume(DetailConstant.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;
  private durations: Array<number> = DetailConstant.RING_DURATION; //响铃时长，分钟
  controller?: CustomDialogController;

  build() {
    Flex() {
      CommonDialog({
        title: '闹铃时长',
        controller: this.controller
      }) {
        ForEach(this.durations, (item: number) => {
          Row() {
            Text(item + ' ' + DetailConstant.DEFAULT_STRING_MINUTE)
              .layoutWeight(1)
              .fontColor('#182431')
              .fontSize(14)
            Radio({ value: item.toString(), group: DetailConstant.DEFAULT_STRING_GROUP_NAME })
              .checked(item === this.alarmItem.duration ? true : false)
              .height(20)
              .width(20)
              .onChange(() => {
                if (!this.controller) {
                  return;
                }
                this.controller.close();
                this.alarmItem.duration = item
              })
          }
          .width('100%')

          Divider()
            .opacity(0.05)
            .color('#182431')
            .lineCap(LineCapStyle.Round)
        })
      }
    }
  }
}