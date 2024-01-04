import router from '@ohos.router';
import { AlarmSettingType, DetailConstant } from '../common/CommonConstants'
import BackContainer from '../view/BackContainer';
import DatePickArea from '../view/Detail/DatePickArea';
import SettingItem from '../view/Detail/SettingItem';
import AlarmItem from '../viewmodel/AlarmItem'
import AlarmSettingItem from '../viewmodel/AlarmSettingItem';
import DetailModel from '../viewmodel/DetailViewModel';

@Entry
@Component
struct DetailIndex {
  @Watch('onAlarmItemChange') @Provide(DetailConstant.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem = new AlarmItem();
  @State repeatSettingArr: Array<AlarmSettingItem> = [];
  @State alarmSettingInfoArr: Array<AlarmSettingItem> = [];
  private isNow: boolean = true;
  private viewModel: DetailModel = DetailModel.instance;

  aboutToAppear() {
    let params = router.getParams() as Record<string, Object|undefined>;
    if (params) {
      let alarmItem: AlarmItem = params.alarmItem as AlarmItem;
      if (alarmItem) {
        this.isNow = false;
        this.alarmItem = alarmItem;
        this.viewModel.setAlarmDefaultTime(this.alarmItem);
      }else {
        this.viewModel.setAlarmDefaultTime();
      }
    } else {
      this.viewModel.setAlarmDefaultTime();
    }
    this.initData();
  }

  onAlarmItemChange() {
    this.initData();
  }

  initData() {
    this.repeatSettingArr = [
      // 重复
      new AlarmSettingItem(DetailConstant.DEFAULT_STRING_REPEAT,
        this.alarmItem.isRepeat ? DetailConstant.DEFAULT_STRING_REPEAT
                                : DetailConstant.DEFAULT_STRING_NO_REPEAT, AlarmSettingType.REPEAT)
    ];
    this.alarmSettingInfoArr = [
      new AlarmSettingItem(DetailConstant.DEFAULT_STRING_ALARM_NAME, this.alarmItem.name, AlarmSettingType.ALARM_NAME),
      new AlarmSettingItem(DetailConstant.DEFAULT_STRING_DURATION,
        this.alarmItem.duration + DetailConstant.DEFAULT_STRING_MINUTE, AlarmSettingType.RING_DURATION),
      new AlarmSettingItem(DetailConstant.DEFAULT_STRING_INTERVAL, this.alarmItem.intervalMinute
      + DetailConstant.DEFAULT_STRING_MINUTE + '，'
      + this.alarmItem.intervalTimes + DetailConstant.DEFAULT_STRING_TIMES, AlarmSettingType.INTERVAL)
    ]
  }

  build() {
    Column() {
      BackContainer({
        header: this.isNow ? '新建闹钟' : '修改闹钟',
        backImageRes: $r('app.media.ic_cancel'),
      }) {
        Button() {
          Image($r('app.media.ic_confirm')).objectFit(ImageFit.Fill)
        }
        .backgroundColor('#00000000')
        .width(24)
        .height(24)
        .onClick(() => {
          this.viewModel.setAlarmRemind(this.alarmItem);
          router.back();
        })
      }

      DatePickArea()

      SettingItem({
        settingInfo: $repeatSettingArr
      })

      SettingItem({
        settingInfo: $alarmSettingInfoArr
      })

      Blank()

      Button('删除')
        .visibility(this.isNow ? Visibility.None : Visibility.Visible)
        .width(120)
        .height(40)
        .fontSize(16)
        .fontColor('#FA2A2D')
        .backgroundColor('#0C182431')
        .borderRadius(20)
        .margin({ bottom: 24 })
        .onClick(() => {
          this.viewModel.removeAlarmRemind(this.alarmItem.id);
          router.back();
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f1f3f5')
  }
}