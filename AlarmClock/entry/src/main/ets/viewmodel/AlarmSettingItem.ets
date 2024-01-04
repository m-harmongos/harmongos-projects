import { AlarmSettingType } from '../common/CommonConstants';

export default class AlarmSettingItem {
  public title: string;
  public content: string;
  public sType: AlarmSettingType;

  constructor(title: string, content: string, sType: AlarmSettingType) {
    this.title = title;
    this.content = content;
    this.sType = sType;
  }
}