*아두이노 코드
#define LINE_DETECT_WHITE 1
#define NO_LINE_SENSOR 5

int LineSensorPin[NO_LINE_SENSOR] = {1, 2, 3, 4, 5};
int LineSensorData[NO_LINE_SENSOR] = {0, 0, 0, 0, 0};

void read_line_sensor(void) 
{
  int i;
  for (int i = 0; i < NO_LINE_SENSOR; i++) 
  {
  
    LineSensorData[i] = digitalRead(LineSensorPin[i]);
  }

}

void send_serial_data(void) 
{
  int i;
  
    Serial.print("*");
    for(i=0;i<NO_LINE_SENSOR;i++) 
  {
  
    Serial.print(LineSensorData[i]);
    Serial.print(" ");
  }
   Serial.println("#");
   Serial.println("");

}

void setup() {
  int i;
  for (i=0;i<NO_LINE_SENSOR;i++) 
  {
    pinMode(LineSensorPin[i], INPUT);
  }
  Serial.begin(115200);

}

void loop() {
  read_line_sensor();
  send_serial_data();
  delay(500);
}


*프로세싱 코드
import processing.serial.*;
Serial port;

int[] line_sensor_data = new int[5];
String Serial_Data_String = null;
void setup()
{
  int i;
  size(700,900);
  
  // port = new Serial(this,"COM4",115200);
  
  for(i=0;i<5;i++) line_sensor_data[i] = 0;
}


void draw()
{
  fill(0,0,255);
  rect(250,350,200,50);
  
  line_sensor_data[0] = 1;
  line_sensor_data[1] = 1;
  line_sensor_data[2] = 1;
  line_sensor_data[3] = 1;
  line_sensor_data[4] = 1;
  
  if(line_sensor_data[0] ==1) fill(255,0,0);
  else                        fill(255,255,255);
  ellipse(270,375,15,15);
  
  if(line_sensor_data[1] ==1) fill(255,0,0);
  else                        fill(255,255,255);
  ellipse(310,375,15,15);
  
  if(line_sensor_data[2] ==1) fill(255,0,0);
  else                        fill(255,255,255);
  ellipse(350,375,15,15);  //center LED
  
  if(line_sensor_data[3] ==1) fill(255,0,0);
  else                        fill(255,255,255);
  ellipse(390,375,15,15);
  if(line_sensor_data[4] ==1) fill(255,0,0);
  else                        fill(255,255,255);
  ellipse(430,375,15,15);
  
  fill(0,0,255);
}

void serialEvent(Serial port){
  
  int i;
  Serial_Data_String = port.readStringUntil('\n');
  
  if(Serial_Data_String != null)
  {
    
    print("input data : ");
    print(Serial_Data_String);
    
    Serial_Data_String = trim(Serial_Data_String);
    String [] values = split(Serial_Data_String," ");
    
    if((values.length == 7) && (values[0].indexOf('#')==0) && (values[6].indexOf('*')==0))
    {
      //print(values[0]);
      //print(" ");
      //print(values[1]);
      //print(" ");
      //print(values[6]);
      //print("\n");
      
      line_sensor_data[0] = int(values[1]);
      line_sensor_data[1] = int(values[2]);
      line_sensor_data[2] = int(values[3]);
      line_sensor_data[3] = int(values[4]);
      line_sensor_data[4] = int(values[5]);
      
      for(i=0;i<5;i++)
      {
        line_sensor_data[i] = int(values[i+1]);
        print(values[i]); print(" ");
      }
      print("\n");
    }
  }
}
