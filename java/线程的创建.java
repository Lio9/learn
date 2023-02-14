public class 线程的创建 {

    
    public static void main(String[] args) throws InterruptedException {
        demo6();
    }

    /*
     * Java语言内置了多线程支持。当Java程序启动的时候，实际上是启动了一个JVM进程，然后，JVM启动主线程来执行main()方法。在main()方法中，
     * 我们又可以启动其他线程。
     * 
     * 要创建一个新线程非常容易，我们需要实例化一个Thread实例，然后调用它的start()方法：
     */
    public void demo1(){
        Thread t = new Thread();
        t.start(); // 启动新线程
    }

    /*
     * 但是这个线程启动后实际上什么也不做就立刻结束了。我们希望新线程能执行指定的代码，有以下几种方法：
     * 
     * 方法一：从Thread派生一个自定义类，然后覆写run()方法：
     */
    public void demo2(){
        Thread t = new MyThread();
        t.start(); // 启动新线程
    }

    class MyThread extends Thread {
        @Override
        public void run() {
            System.out.println("start new thread!");
        }
    }

    /*
     * 执行上述代码，注意到start()方法会在内部自动调用实例的run()方法。
     * 
     * 方法二：创建Thread实例时，传入一个Runnable实例：
     */
    public void demo3(){
        Thread t = new Thread(new MyRunnable());
        t.start(); // 启动新线程
    }

    class MyRunnable implements Runnable {
        @Override
        public void run() {
            System.out.println("start new thread!");
        }
    }

    /*
     * 或者用Java8引入的lambda语法进一步简写为：
     */
    public void demo4(){
        Thread t = new Thread(() -> {
            System.out.println("start new thread!");
        });
        t.start(); // 启动新线程
    }

    /*
     * 要模拟并发执行的效果，我们可以在线程中调用Thread.sleep()，强迫当前线程暂停一段时间：
     */

    public static void demo5(){
        System.out.println("main start...");
        Thread t = new Thread() {
            public void run() {
                System.out.println("thread run...");
                try {
                    Thread.sleep(10);
                } catch (InterruptedException e) {
                }
                System.out.println("thread end.");
            }
        };
        t.start();
        try {
            Thread.sleep(20);
        } catch (InterruptedException e) {
        }
        System.out.println("main end...");
    }

    /*
     * 一个线程还可以等待另一个线程直到其运行结束。例如，main线程在启动t线程后，可以通过t.join()等待t线程结束后再继续运行
     */
    public static void demo6() throws InterruptedException{
        Thread t = new Thread(() -> {
            System.out.println("hello");
        });
        System.out.println("start");
        t.start();
        t.join();
        System.out.println("end");
    }

}
