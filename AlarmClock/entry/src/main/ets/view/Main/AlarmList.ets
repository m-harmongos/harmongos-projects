import router from '@ohos.router';
import AlarmItem from '../../viewmodel/AlarmItem';
import AlarmListItem from './AlarmListItem';

@Component
export default struct AlarmList {
  @Link alarmItems: Array<AlarmItem>;

  build() {
    List({ space: 12 }) {
      ForEach(this.alarmItems, (item: AlarmItem) => {
        ListItem() {
          AlarmListItem({ alarmItem: item })
        }
        .onClick(() => {
          router.pushUrl({ url: 'pages/DetailIndex', params: { alarmItem: item }});
        })
      }, (item: AlarmItem) => JSON.stringify(item))
    }
    .padding({ left: 12, right: 12 })
    .listDirection(Axis.Vertical)
    .layoutWeight(1)
    .margin({ top: 12 })
  }
}