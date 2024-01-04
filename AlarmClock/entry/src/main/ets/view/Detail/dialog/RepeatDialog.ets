
import { DetailConstant } from '../../../common/CommonConstants';
import AlarmItem from '../../../viewmodel/AlarmItem';
import DetailModel from '../../../viewmodel/DetailViewModel';
import CommonDialog from './CommonDialog';

@CustomDialog
export default struct RepeatDialog {
  @Consume(DetailConstant.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;
  private viewModel: DetailModel = DetailModel.instance;
  private selects: number[] = [];
  controller: CustomDialogController
  //   = new CustomDialogController({
  //   builder: RepeatDialog(),
  //   autoCancel: true
  // });

  aboutToAppear() {
    // 深拷贝
    let newObj: number[] = [];
    for (let i = 0; i < this.alarmItem.repeatDays.length; i++) {
      newObj[i] = JSON.parse(JSON.stringify(this.alarmItem.repeatDays[i]));
    }
    this.selects = newObj;
  }

  build() {
    Flex() {
      CommonDialog({
        title: '重复',
        controller: this.controller,
        onConfirm: () => {
          this.selects.sort();
          this.alarmItem.repeatDays = this.selects;
          this.alarmItem.isRepeat = this.selects.length > 0;
        }
      }) {
        ForEach(DetailConstant.WEEKDAY_DATA, (item: number) => {
          Row() {
            Text(this.viewModel.transAlarmRepeatDayContent(item))
              .layoutWeight(1)
              .fontColor('#182431')
              .fontSize(14)

            Checkbox({ name: item.toString() })
              .select(this.alarmItem.repeatDays.indexOf(item) !== -1)
              .width(20)
              .height(20)
              .onChange((value: boolean) => {
                if (value) {
                  this.selects.push(item);
                } else {
                  let index = this.selects.indexOf(item);
                  this.selects.splice(index, 1);
                }
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