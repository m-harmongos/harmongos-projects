import { DayDataItem, DetailConstant } from '../../common/CommonConstants'
@Component
export default struct DatePickArea {
  build() {
    Stack() {
      Row() {
        ForEach(DetailConstant.DAY_DATA, (item: DayDataItem) => {
          TextPicker({ range: item.data, selected: item.delSelect })
            .layoutWeight(1)
            .backgroundColor('#f1f3f5')
            .onChange((value: string, index: number) => {
              item.delSelect = index;
            })
        }, (item: DayDataItem) => JSON.stringify(item));
      }
    }
    .height(200)
    .padding({ left: 24, right: 24 })
  }
}