import MainModel from '../../viewmodel/MainViewModel';

@Preview
@Component
export default struct ClockArea {
  private mainModel: MainModel = MainModel.instance;
  // 计时器ID
  private drawInterval: number = -1;
  private canvasSize: number = 252;
  private clockRadius: number =  this.canvasSize/2 - 2;
  // canvas
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private renderContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  @State showClock: boolean = false;

  aboutToAppear() {
    clearInterval(this.drawInterval);
  }

  build() {
    Canvas(this.renderContext)
      .width(this.canvasSize)
      .aspectRatio(1)
      .onReady(() => {
        if (this.drawInterval === -1) {
          this.startDrawTask();
        }
      })
      .onClick(() => {
        this.showClock = !this.showClock;
      })
  }

  // 启动绘画任务
  private startDrawTask() {
    this.renderContext.translate(this.canvasSize/2, this.canvasSize/2);
    this.drawClockArea();
    this.drawInterval = setInterval(() => {
      this.drawClockArea();
    }, 1000);
  }

  // 开始绘制时钟区域
  private drawClockArea() {
    this.renderContext.clearRect(-this.canvasSize, -this.canvasSize/2, this.canvasSize*2, this.canvasSize);
    let date = new Date();
    let hours = date.getHours();
    let minutes = date.getMinutes();
    let seconds = date.getSeconds();
    if (this.showClock) {
      this.drawPan();
      this.drawPointer(30 * (hours > 12 ? hours - 12 : hours) + minutes / 12 * 6, '../../../resources/base/media/ic_hour_pointer.png');
      this.drawPointer(6 * minutes, '../../../resources/base/media/ic_minute_pointer.png');
      this.drawPointer(6 * seconds, '../../../resources/base/media/ic_second_pointer.png');
    } else {
      this.drawTime(hours, minutes, seconds);
    }
  }

  // 画表盘
  private drawPan() {
    this.renderContext.beginPath();
    let secondImg = new ImageBitmap('../../../resources/base/media/ic_clock_pan.png');
    this.renderContext.drawImage(secondImg, -this.clockRadius, -this.clockRadius, this.clockRadius*2, this.clockRadius*2);
    this.renderContext.restore();
  }

  // 绘制时针、分针、秒针
  /// degree: 角度， pointerImageRes: 图片
  private drawPointer(degree: number, pointerImageRes: string) {
    this.renderContext.save();
    let theta = (degree + 180) * Math.PI / 180;
    this.renderContext.rotate(theta);
    this.renderContext.beginPath();
    let secondImg = new ImageBitmap(pointerImageRes);
    let imgWidth = 10;
    this.renderContext.drawImage(secondImg, -imgWidth/2, -this.clockRadius, imgWidth, this.clockRadius*2);
    this.renderContext.restore();
  }

  // 绘制时间
  private drawTime(hours: number, minutes: number, seconds: number) {
    let time = this.mainModel.fillZero(hours) + ':' + this.mainModel.fillZero(minutes) + ':' + this.mainModel.fillZero(seconds);
    this.renderContext.save();
    this.renderContext.font = '60px';
    this.renderContext.beginPath();
    this.renderContext.textAlign = 'center';
    this.renderContext.fillText(time, 0, 0);
    this.renderContext.restore();
  }
}