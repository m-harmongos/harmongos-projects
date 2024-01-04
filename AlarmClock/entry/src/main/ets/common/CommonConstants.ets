export class CommonConstants {
  // 首选项存储ID
  static readonly PREFERENCE_ID = 'storageId';
  static readonly DEFAULT_TOTAL_MINUTE: number = 60;
  // bundleName
  static readonly BUNDLE_NAME: string = 'com.misterzhou.alarmclock';
  // ablilityName
  static readonly ABILITY_NAME: string = 'EntryAbility';
  // 提醒key
  static readonly ALARM_KEY = 'alarmData';
}

export enum WeekDays {
  DEFAULT_NUMBER_MONDAY = 1,
  DEFAULT_NUMBER_TUESDAY = 2,
  DEFAULT_NUMBER_WEDNESDAY = 3,
  DEFAULT_NUMBER_THURSDAY = 4,
  DEFAULT_NUMBER_FRIDAY = 5,
  DEFAULT_NUMBER_SATURDAY = 6,
  DEFAULT_NUMBER_SUNDAY = 7
}

export class DayDataItem {
  timeType: number = 0;
  delSelect: number = 0;
  data: Array<string> = [];
}

export class DetailConstant {
  /**
   * detail page day data.
   */
  static readonly DAY_DATA: DayDataItem[] = [
    { timeType: 0, delSelect: 0, data: ['上午', '下午'] } as DayDataItem,
    { timeType: 1, delSelect: 0, data:
    [
      '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'
    ]
    } as DayDataItem,
    { timeType: 2, delSelect: 0, data:
    [
      '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12',
      '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24',
      '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36',
      '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48',
      '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '00',
    ]
    } as DayDataItem
  ];
  /**
   * week day data.
   */
  static readonly WEEKDAY_DATA: number[] = [1, 2, 3, 4, 5, 6, 7];
  /**
   * ring duration list data.
   */
  static readonly RING_DURATION: number[] = [1, 5, 10, 15, 20, 30];
  /**
   * default string minute.
   */
  static readonly DEFAULT_STRING_MINUTE: string = '分钟';
  /**
   * default string group name.
   */
  static readonly DEFAULT_STRING_GROUP_NAME: string = 'radioGroup';
  /**
   * default string provider key.
   */
  static readonly DEFAULT_PROVIDER_KEY: string = 'alarmItemProvide';
  /**
   * default string repeat.
   */
  static readonly DEFAULT_STRING_REPEAT: string = '重复';
  static readonly DEFAULT_STRING_NO_REPEAT: string = '不重复';
  /**
   * default string alarm name.
   */
  static readonly DEFAULT_STRING_ALARM_NAME: string = '闹钟名';
  /**
   * default string interval.
   */
  static readonly DEFAULT_STRING_INTERVAL: string = '再响间隔';
  /**
   * default string duration.
   */
  static readonly DEFAULT_STRING_DURATION: string = '闹铃时长';
  /**
   * default string times.
   */
  static readonly DEFAULT_STRING_TIMES: string = '次';
}

export enum AlarmSettingType {
  /**
   * Alarm setting type repeat.
   */
  REPEAT,

  /**
   * Alarm setting type name.
   */
  ALARM_NAME,

  /**
   * Alarm setting type ring duration.
   */
  RING_DURATION,

  /**
   * Alarm setting type interval.
   */
  INTERVAL
}